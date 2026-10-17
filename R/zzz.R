# Declare variables used inside dplyr/tidyr data masks (NSE) so that
# R CMD check does not flag them as undefined global variables.
utils::globalVariables(c(
  ".",
  "BeatByChild", "BeatByParent", "BiasParent", "ChildBias", "CladeSize",
  "Count", "DDD", "EdgeLength", "Freq", "LLL", "N1", "N2", "NodeName",
  "ParentBias", "Size", "StaticBC", "TipAnn", "Total", "Var1", "Var2",
  "isP2D", "isRoot", "isTip", "label", "parent", "value"
))
