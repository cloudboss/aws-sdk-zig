/// Used to specify configuration options for a volume’s storage aggregate or
/// aggregates.
pub const AggregateConfiguration = struct {
    /// The list of aggregates that this volume resides on. Aggregates are storage
    /// pools which make up your primary storage tier. Each high-availability (HA)
    /// pair has one aggregate. The names of the aggregates map to the names of the
    /// aggregates in the ONTAP CLI and REST API. For FlexVols, there will always be
    /// a single entry.
    ///
    /// Amazon FSx responds with an HTTP status code 400 (Bad Request) for the
    /// following conditions:
    ///
    /// * The strings in the value of `Aggregates` are not are not formatted as
    ///   `aggrX`, where X is a number between 1 and 12.
    ///
    /// * The value of `Aggregates` contains aggregates that are not present.
    ///
    /// * One or more of the aggregates supplied are too close to the volume limit
    ///   to support adding more volumes.
    aggregates: ?[]const []const u8 = null,

    /// The total number of constituents this FlexGroup volume has. Not applicable
    /// for FlexVols.
    total_constituents: ?i32 = null,

    pub const json_field_names = .{
        .aggregates = "Aggregates",
        .total_constituents = "TotalConstituents",
    };
};
