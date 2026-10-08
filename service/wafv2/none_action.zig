/// Specifies that WAF should do nothing. This is used for the
/// `OverrideAction` setting on a Rule when the rule uses a
/// rule group reference statement.
///
/// This is used in the context of other settings, for example to specify values
/// for RuleAction and web ACL DefaultAction.
///
/// JSON specification: `"None": {}`
pub const NoneAction = struct {};
