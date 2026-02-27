const PayloadType = @import("payload_type.zig").PayloadType;

/// Information needed to configure the payload.
///
/// By default, AWS IoT Events generates a standard payload in JSON for any
/// action. This action payload
/// contains all attribute-value pairs that have the information about the
/// detector model instance
/// and the event triggered the action. To configure the action payload, you can
/// use
/// `contentExpression`.
pub const Payload = struct {
    /// The content of the payload. You can use a string expression that includes
    /// quoted strings
    /// (`''`), variables (`$variable.`),
    /// input values (`$input..`), string
    /// concatenations, and quoted strings that contain `${}` as the content. The
    /// recommended maximum size of a content expression is 1 KB.
    content_expression: []const u8,

    /// The value of the payload type can be either `STRING` or
    /// `JSON`.
    type: PayloadType,

    pub const json_field_names = .{
        .content_expression = "contentExpression",
        .type = "type",
    };
};
