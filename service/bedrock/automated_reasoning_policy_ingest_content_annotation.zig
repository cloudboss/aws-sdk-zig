/// An annotation for processing and incorporating new content into an Automated
/// Reasoning policy.
pub const AutomatedReasoningPolicyIngestContentAnnotation = struct {
    /// The new content to be analyzed and incorporated into the policy, such as
    /// additional documents or rule descriptions.
    content: []const u8,

    pub const json_field_names = .{
        .content = "content",
    };
};
