const FunctionType = @import("function_type.zig").FunctionType;
const PrincipalType = @import("principal_type.zig").PrincipalType;
const ResourceUri = @import("resource_uri.zig").ResourceUri;

/// Represents the equivalent of a Hive user-defined function
/// (`UDF`) definition.
pub const UserDefinedFunction = struct {
    /// The ID of the Data Catalog in which the function resides.
    catalog_id: ?[]const u8 = null,

    /// The Java class that contains the function code.
    class_name: ?[]const u8 = null,

    /// The time at which the function was created.
    create_time: ?i64 = null,

    /// The name of the catalog database that contains the function.
    database_name: ?[]const u8 = null,

    /// The name of the function.
    function_name: ?[]const u8 = null,

    /// The type of the function.
    function_type: ?FunctionType = null,

    /// The owner of the function.
    owner_name: ?[]const u8 = null,

    /// The owner type.
    owner_type: ?PrincipalType = null,

    /// The resource URIs for the function.
    resource_uris: ?[]const ResourceUri = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .class_name = "ClassName",
        .create_time = "CreateTime",
        .database_name = "DatabaseName",
        .function_name = "FunctionName",
        .function_type = "FunctionType",
        .owner_name = "OwnerName",
        .owner_type = "OwnerType",
        .resource_uris = "ResourceUris",
    };
};
