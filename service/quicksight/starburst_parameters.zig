const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const OAuthParameters = @import("o_auth_parameters.zig").OAuthParameters;
const StarburstProductType = @import("starburst_product_type.zig").StarburstProductType;

/// The parameters that are required to connect to a Starburst data source.
pub const StarburstParameters = struct {
    /// The authentication type that you want to use for your connection. This
    /// parameter accepts OAuth and non-OAuth authentication types.
    authentication_type: ?AuthenticationType,

    /// The catalog name for the Starburst data source.
    catalog: []const u8,

    /// The database access control role.
    database_access_control_role: ?[]const u8,

    /// The host name of the Starburst data source.
    host: []const u8,

    /// An object that contains information needed to create a data source
    /// connection between an Quick Sight account and Starburst.
    o_auth_parameters: ?OAuthParameters,

    /// The port for the Starburst data source.
    port: i32,

    /// The product type for the Starburst data source.
    product_type: ?StarburstProductType,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .catalog = "Catalog",
        .database_access_control_role = "DatabaseAccessControlRole",
        .host = "Host",
        .o_auth_parameters = "OAuthParameters",
        .port = "Port",
        .product_type = "ProductType",
    };
};
