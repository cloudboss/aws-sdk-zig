/// A partner event source is created by an SaaS partner. If a customer creates
/// a partner
/// event bus that matches this event source, that Amazon Web Services account
/// can receive events from the
/// partner's applications or services.
pub const PartnerEventSource = struct {
    /// The ARN of the partner event source.
    arn: ?[]const u8,

    /// The name of the partner event source.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
