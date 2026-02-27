const FunctionType = @import("function_type.zig").FunctionType;
const PrincipalType = @import("principal_type.zig").PrincipalType;
const ResourceUri = @import("resource_uri.zig").ResourceUri;

/// A structure used to create or update a user-defined function.
pub const UserDefinedFunctionInput = struct {
    /// The Java class that contains the function code.
    class_name: ?[]const u8,

    /// The name of the function.
    function_name: ?[]const u8,

    /// The type of the function.
    function_type: ?FunctionType,

    /// The owner of the function.
    owner_name: ?[]const u8,

    /// The owner type.
    owner_type: ?PrincipalType,

    /// The resource URIs for the function.
    resource_uris: ?[]const ResourceUri,

    pub const json_field_names = .{
        .class_name = "ClassName",
        .function_name = "FunctionName",
        .function_type = "FunctionType",
        .owner_name = "OwnerName",
        .owner_type = "OwnerType",
        .resource_uris = "ResourceUris",
    };
};
