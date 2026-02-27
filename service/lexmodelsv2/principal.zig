/// The IAM principal that you allowing or denying access to an Amazon Lex
/// action. You must provide a `service` or an `arn`,
/// but not both in the same statement. For more information, see [ AWS JSON
/// policy elements: Principal
/// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html).
pub const Principal = struct {
    /// The Amazon Resource Name (ARN) of the principal.
    arn: ?[]const u8,

    /// The name of the Amazon Web Services service that should allowed or denied
    /// access to
    /// an Amazon Lex action.
    service: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .service = "service",
    };
};
