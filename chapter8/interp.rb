require "minruby"

def evaluate(tree, genv, lenv)
  case tree[0]
  when "lit"
    tree[1]
  when "+"
    evaluate(tree[1], genv, lenv) + evaluate(tree[2], genv, lenv)
  when "-"
    evaluate(tree[1], genv, lenv) - evaluate(tree[2], genv, lenv)
  when "*"
    evaluate(tree[1], genv, lenv) * evaluate(tree[2], genv, lenv)
  when "/"
    evaluate(tree[1], genv, lenv) / evaluate(tree[2], genv, lenv)
  when "%"
    evaluate(tree[1], genv, lenv) % evaluate(tree[2], genv, lenv)
  when "**"
    evaluate(tree[1], genv, lenv) ** evaluate(tree[2], genv, lenv)
  when "=="
    evaluate(tree[1], genv, lenv) == evaluate(tree[2], genv, lenv)
  when "<"
    evaluate(tree[1], genv, lenv) < evaluate(tree[2], genv, lenv)
  when ">"
    evaluate(tree[1], genv, lenv) > evaluate(tree[2], genv, lenv)
  when "func_call"
    args = []
    i = 0
    while tree[i + 2]
      args[i] = evaluate(tree[i+2], genv, lenv)
      i = i + 1
    end
    mhd = genv[tree[1]]
    if mhd[0] == "builtin"
      minruby_call(mhd[1], args)
    else
      new_lenv = {}
      params = mhd[1]
      i = 0
      while params[i]
        new_lenv[params[i]] = args[i]
        i = i + 1
      end
      evaluate(mhd[2], genv, new_lenv)
    end
  when "func_def"
    genv[tree[1]] = ["user_defined", tree[2], tree[3]]
  when "stmts"
    i = 1
    last = nil
    while tree[i]
      last = evaluate(tree[i], genv, lenv)
      i += 1
    end
    last
  when "var_assign"
    lenv[tree[1]] = evaluate(tree[2], genv, lenv)
  when "var_ref"
    lenv[tree[1]]
  when "if"
    if evaluate(tree[1], genv, lenv)
      evaluate(tree[2], genv, lenv)
    else
      evaluate(tree[3], genv, lenv)
    end
  when "while"
    while evaluate(tree[1], genv, lenv)
      evaluate(tree[2], genv, lenv)
    end
  end
end

str = minruby_load()
tree = minruby_parse(str)
p(tree)
genv = { "p" => ["builtin", "p"], "add" => ["builtin", "add"] }
lenv = {}
evaluate(tree, genv, lenv)
