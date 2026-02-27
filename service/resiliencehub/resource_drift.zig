const DifferenceType = @import("difference_type.zig").DifferenceType;
const ResourceIdentifier = @import("resource_identifier.zig").ResourceIdentifier;

/// Indicates the resources that have drifted in the current application
/// version.
pub const ResourceDrift = struct {
    /// Amazon Resource Name (ARN) of the application whose resources have drifted.
    /// The format for this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app-assessment/`app-id`.
    /// For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: ?[]const u8,

    /// Version of the application whose resources have drifted.
    app_version: ?[]const u8,

    /// Indicates if the resource was added or removed.
    diff_type: ?DifferenceType,

    /// Reference identifier of the resource drift.
    reference_id: ?[]const u8,

    /// Identifier of the drifted resource.
    resource_identifier: ?ResourceIdentifier,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .app_version = "appVersion",
        .diff_type = "diffType",
        .reference_id = "referenceId",
        .resource_identifier = "resourceIdentifier",
    };
};
