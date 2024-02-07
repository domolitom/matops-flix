use File.open

def twosumcalc(l: List[a], target: a): List[a] with Eq[a], Add[a] = 
  match l {
    case Nil => Nil
    case _ :: Nil => Nil
    case f :: s :: xs => if (target == f + s) f :: s :: Nil else List.append(twosumcalc(s :: xs, target), twosumcalc(f :: xs, target))
  }

// Evil function! A package that contains unchecked_cast should be marked unsafe.
def twosum(l: List[a], target: a): List[a] with Eq[a], Add[a]=
  let _ = unchecked_cast(Files.mkdir("evil") as _ \ {});
  twosumcalc(l, target)