const DatabaseLFTagPolicyAndPermissions = @import("database_lf_tag_policy_and_permissions.zig").DatabaseLFTagPolicyAndPermissions;
const TableLFTagPolicyAndPermissions = @import("table_lf_tag_policy_and_permissions.zig").TableLFTagPolicyAndPermissions;

/// Details from an import AWS Lake Formation tag policy job response.
pub const ImportAssetsFromLakeFormationTagPolicyResponseDetails = struct {
    /// The identifier for the AWS Glue Data Catalog.
    catalog_id: []const u8,

    /// A structure for the database object.
    database: ?DatabaseLFTagPolicyAndPermissions = null,

    /// The unique identifier for the data set associated with this import job.
    data_set_id: []const u8,

    /// The unique identifier for the revision associated with this import job.
    revision_id: []const u8,

    /// The IAM role's ARN that allows AWS Data Exchange to assume the role and
    /// grant and revoke
    /// permissions to AWS Lake Formation data permissions.
    role_arn: []const u8,

    /// A structure for the table object.
    table: ?TableLFTagPolicyAndPermissions = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database = "Database",
        .data_set_id = "DataSetId",
        .revision_id = "RevisionId",
        .role_arn = "RoleArn",
        .table = "Table",
    };
};
