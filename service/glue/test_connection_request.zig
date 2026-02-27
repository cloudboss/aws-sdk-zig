const TestConnectionInput = @import("test_connection_input.zig").TestConnectionInput;

pub const TestConnectionRequest = struct {
    /// The catalog ID where the connection resides.
    catalog_id: ?[]const u8,

    /// Optional. The name of the connection to test. If only name is provided, the
    /// operation will get the connection and use that for testing.
    connection_name: ?[]const u8,

    /// A structure that is used to specify testing a connection to a service.
    test_connection_input: ?TestConnectionInput,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .connection_name = "ConnectionName",
        .test_connection_input = "TestConnectionInput",
    };
};
