const DataTransferApiType = @import("data_transfer_api_type.zig").DataTransferApiType;

/// The API of the connector application that Amazon AppFlow uses to transfer
/// your
/// data.
pub const DataTransferApi = struct {
    /// The name of the connector application API.
    name: ?[]const u8 = null,

    /// You can specify one of the following types:
    ///
    /// **AUTOMATIC**
    ///
    /// The default. Optimizes a flow for datasets that fluctuate in size from small
    /// to
    /// large. For each flow run, Amazon AppFlow chooses to use the SYNC or ASYNC
    /// API type
    /// based on the amount of data that the run transfers.
    ///
    /// **SYNC**
    ///
    /// A synchronous API. This type of API optimizes a flow for small to
    /// medium-sized
    /// datasets.
    ///
    /// **ASYNC**
    ///
    /// An asynchronous API. This type of API optimizes a flow for large datasets.
    @"type": ?DataTransferApiType = null,

    pub const json_field_names = .{
        .name = "Name",
        .@"type" = "Type",
    };
};
