/// This action must be set if `TriggerEventSource` is one of the following
/// values:
/// `OnPostCallAnalysisAvailable` | `OnRealTimeCallAnalysisAvailable` |
/// `OnRealTimeChatAnalysisAvailable` | `OnPostChatAnalysisAvailable`. Contact
/// is categorized
/// using the rule name.
///
/// `RuleName` is used as `ContactCategory`.
pub const AssignContactCategoryActionDefinition = struct {
};
