const CatalogResource = @import("catalog_resource.zig").CatalogResource;
const DatabaseResource = @import("database_resource.zig").DatabaseResource;
const DataCellsFilterResource = @import("data_cells_filter_resource.zig").DataCellsFilterResource;
const DataLocationResource = @import("data_location_resource.zig").DataLocationResource;
const LFTagKeyResource = @import("lf_tag_key_resource.zig").LFTagKeyResource;
const LFTagExpressionResource = @import("lf_tag_expression_resource.zig").LFTagExpressionResource;
const LFTagPolicyResource = @import("lf_tag_policy_resource.zig").LFTagPolicyResource;
const TableResource = @import("table_resource.zig").TableResource;
const TableWithColumnsResource = @import("table_with_columns_resource.zig").TableWithColumnsResource;

/// A structure for the resource.
pub const Resource = struct {
    /// The identifier for the Data Catalog. By default, the account ID. The Data
    /// Catalog is the persistent metadata store. It contains database definitions,
    /// table definitions, and other control information to manage your Lake
    /// Formation environment.
    catalog: ?CatalogResource = null,

    /// The database for the resource. Unique to the Data Catalog. A database is a
    /// set of associated table definitions organized into a logical group. You can
    /// Grant and Revoke database permissions to a principal.
    database: ?DatabaseResource = null,

    /// A data cell filter.
    data_cells_filter: ?DataCellsFilterResource = null,

    /// The location of an Amazon S3 path where permissions are granted or revoked.
    data_location: ?DataLocationResource = null,

    /// The LF-Tag key and values attached to a resource.
    lf_tag: ?LFTagKeyResource = null,

    /// LF-Tag expression resource. A logical expression composed of one or more
    /// LF-Tag key:value pairs.
    lf_tag_expression: ?LFTagExpressionResource = null,

    /// A list of LF-tag conditions or saved LF-Tag expressions that define a
    /// resource's LF-tag policy.
    lf_tag_policy: ?LFTagPolicyResource = null,

    /// The table for the resource. A table is a metadata definition that represents
    /// your data. You can Grant and Revoke table privileges to a principal.
    table: ?TableResource = null,

    /// The table with columns for the resource. A principal with permissions to
    /// this resource can select metadata from the columns of a table in the Data
    /// Catalog and the underlying data in Amazon S3.
    table_with_columns: ?TableWithColumnsResource = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .database = "Database",
        .data_cells_filter = "DataCellsFilter",
        .data_location = "DataLocation",
        .lf_tag = "LFTag",
        .lf_tag_expression = "LFTagExpression",
        .lf_tag_policy = "LFTagPolicy",
        .table = "Table",
        .table_with_columns = "TableWithColumns",
    };
};
