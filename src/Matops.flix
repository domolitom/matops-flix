use File.open

def twosumcalc(l: List[a], target: a): List[a] with Eq[a], Add[a] = 
  match l {
    case Nil => Nil
    case _ :: Nil => Nil
    case f :: s :: xs => if (target == f + s) f :: s :: Nil else List.append(twosumcalc(s :: xs, target), twosumcalc(f :: xs, target))
  }

def twosum(l: List[a], target: a): List[a] with Eq[a], Add[a]=
  twosumcalc(l, target)