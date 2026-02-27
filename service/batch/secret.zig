/// An object that represents the secret to expose to your container. Secrets
/// can be exposed to
/// a container in the following ways:
///
/// * To inject sensitive data into your containers as environment variables,
///   use the
/// `secrets` container definition parameter.
///
/// * To reference sensitive information in the log configuration of a
///   container, use the
/// `secretOptions` container definition parameter.
///
/// For more information, see [Specifying sensitive
/// data](https://docs.aws.amazon.com/batch/latest/userguide/specifying-sensitive-data.html) in the
/// *Batch User Guide*.
pub const Secret = struct {
    /// The name of the secret.
    name: []const u8,

    /// The secret to expose to the container. The supported values are either the
    /// full Amazon Resource Name (ARN) of
    /// the Secrets Manager secret or the full ARN of the parameter in the Amazon
    /// Web Services Systems Manager Parameter Store.
    ///
    /// If the Amazon Web Services Systems Manager Parameter Store parameter exists
    /// in the same Region as the job you're
    /// launching, then you can use either the full Amazon Resource Name (ARN) or
    /// name of the parameter. If the parameter
    /// exists in a different Region, then the full ARN must be specified.
    value_from: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value_from = "valueFrom",
    };
};
