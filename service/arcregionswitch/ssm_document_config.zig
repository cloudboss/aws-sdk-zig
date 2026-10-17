const aws = @import("aws");

const SsmTarget = @import("ssm_target.zig").SsmTarget;

/// The Systems Manager document to run and the managed nodes to target for a
/// single Amazon Web Services Region.
pub const SsmDocumentConfig = struct {
    /// The cross-account role for the configuration.
    cross_account_role: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Systems Manager document to run.
    document_arn: []const u8,

    /// The version of the Systems Manager document to run for this Region. When you
    /// omit it, Systems Manager runs the document's default version.
    document_version: ?[]const u8 = null,

    /// The external ID (secret key) for the configuration.
    external_id: ?[]const u8 = null,

    /// The parameters that are passed to this Region's Systems Manager document.
    /// You set parameters for each document, so each Region can run its document
    /// with its own parameters.
    parameters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The target filters that Systems Manager resolves to managed nodes when the
    /// command runs. To target specific managed nodes, use the `InstanceIds` key.
    /// You can specify up to five target filters.
    targets: []const SsmTarget,

    pub const json_field_names = .{
        .cross_account_role = "crossAccountRole",
        .document_arn = "documentArn",
        .document_version = "documentVersion",
        .external_id = "externalId",
        .parameters = "parameters",
        .targets = "targets",
    };
};
