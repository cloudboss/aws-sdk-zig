/// The authorizer summary.
pub const AuthorizerSummary = struct {
    /// The authorizer ARN.
    authorizer_arn: ?[]const u8,

    /// The authorizer name.
    authorizer_name: ?[]const u8,

    pub const json_field_names = .{
        .authorizer_arn = "authorizerArn",
        .authorizer_name = "authorizerName",
    };
};
