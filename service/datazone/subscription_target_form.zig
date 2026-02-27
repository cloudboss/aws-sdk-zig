/// The details of the subscription target configuration.
pub const SubscriptionTargetForm = struct {
    /// The content of the subscription target configuration.
    content: []const u8,

    /// The form name included in the subscription target configuration.
    form_name: []const u8,

    pub const json_field_names = .{
        .content = "content",
        .form_name = "formName",
    };
};
