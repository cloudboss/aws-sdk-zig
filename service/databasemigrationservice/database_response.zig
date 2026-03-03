const CollectorShortInfoResponse = @import("collector_short_info_response.zig").CollectorShortInfoResponse;
const ServerShortInfoResponse = @import("server_short_info_response.zig").ServerShortInfoResponse;
const DatabaseInstanceSoftwareDetailsResponse = @import("database_instance_software_details_response.zig").DatabaseInstanceSoftwareDetailsResponse;

/// Describes a database in a Fleet Advisor collector inventory.
pub const DatabaseResponse = struct {
    /// A list of collectors associated with the database.
    collectors: ?[]const CollectorShortInfoResponse = null,

    /// The ID of a database in a Fleet Advisor collector inventory.
    database_id: ?[]const u8 = null,

    /// The name of a database in a Fleet Advisor collector inventory.
    database_name: ?[]const u8 = null,

    /// The IP address of a database in a Fleet Advisor collector inventory.
    ip_address: ?[]const u8 = null,

    /// The number of schemas in a Fleet Advisor collector inventory database.
    number_of_schemas: ?i64 = null,

    /// The server name of a database in a Fleet Advisor collector inventory.
    server: ?ServerShortInfoResponse = null,

    /// The software details of a database in a Fleet Advisor collector inventory,
    /// such as database engine and
    /// version.
    software_details: ?DatabaseInstanceSoftwareDetailsResponse = null,

    pub const json_field_names = .{
        .collectors = "Collectors",
        .database_id = "DatabaseId",
        .database_name = "DatabaseName",
        .ip_address = "IpAddress",
        .number_of_schemas = "NumberOfSchemas",
        .server = "Server",
        .software_details = "SoftwareDetails",
    };
};
