/// The DynamoDB reservations that Amazon Web Services recommends that you
/// purchase.
pub const DynamoDBCapacityDetails = struct {
    /// The capacity unit of the recommended reservation.
    capacity_units: ?[]const u8 = null,

    /// The Amazon Web Services Region of the recommended reservation.
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_units = "CapacityUnits",
        .region = "Region",
    };
};
