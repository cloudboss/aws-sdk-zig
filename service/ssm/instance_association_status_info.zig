const InstanceAssociationOutputUrl = @import("instance_association_output_url.zig").InstanceAssociationOutputUrl;

/// Status information about the association.
pub const InstanceAssociationStatusInfo = struct {
    /// The association ID.
    association_id: ?[]const u8,

    /// The name of the association applied to the managed node.
    association_name: ?[]const u8,

    /// The version of the association applied to the managed node.
    association_version: ?[]const u8,

    /// Detailed status information about the association.
    detailed_status: ?[]const u8,

    /// The association document versions.
    document_version: ?[]const u8,

    /// An error code returned by the request to create the association.
    error_code: ?[]const u8,

    /// The date the association ran.
    execution_date: ?i64,

    /// Summary information about association execution.
    execution_summary: ?[]const u8,

    /// The managed node ID where the association was created.
    instance_id: ?[]const u8,

    /// The name of the association.
    name: ?[]const u8,

    /// A URL for an S3 bucket where you want to store the results of this request.
    output_url: ?InstanceAssociationOutputUrl,

    /// Status information about the association.
    status: ?[]const u8,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .association_name = "AssociationName",
        .association_version = "AssociationVersion",
        .detailed_status = "DetailedStatus",
        .document_version = "DocumentVersion",
        .error_code = "ErrorCode",
        .execution_date = "ExecutionDate",
        .execution_summary = "ExecutionSummary",
        .instance_id = "InstanceId",
        .name = "Name",
        .output_url = "OutputUrl",
        .status = "Status",
    };
};
