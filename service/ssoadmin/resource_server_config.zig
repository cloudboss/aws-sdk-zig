const aws = @import("aws");

const ResourceServerScopeDetails = @import("resource_server_scope_details.zig").ResourceServerScopeDetails;

/// A structure that describes the configuration of a resource server.
pub const ResourceServerConfig = struct {
    /// A list of the IAM Identity Center access scopes that are associated with
    /// this resource server.
    scopes: ?[]const aws.map.MapEntry(ResourceServerScopeDetails),

    pub const json_field_names = .{
        .scopes = "Scopes",
    };
};
