/// The shape containing the requested deployment parameter name and
/// secretString.
///
/// To support AWS CloudFormation dynamic references to this resource using
/// Quick Launch,
/// this value must match a parameter defined in the CloudFormation templated
/// provided to
/// buyers.
pub const DeploymentParameterInput = struct {
    /// The desired name of the deployment parameter. This is the identifier on
    /// which deployment parameters are keyed for a given buyer and product. If this
    /// name matches an existing deployment parameter, this request will update the
    /// existing resource.
    name: []const u8,

    /// The text to encrypt and store in the secret.
    secret_string: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .secret_string = "secretString",
    };
};
