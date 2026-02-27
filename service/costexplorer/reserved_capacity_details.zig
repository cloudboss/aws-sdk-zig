const DynamoDBCapacityDetails = @import("dynamo_db_capacity_details.zig").DynamoDBCapacityDetails;

/// Details about the reservations that Amazon Web Services recommends that you
///
/// purchase.
pub const ReservedCapacityDetails = struct {
    /// The DynamoDB reservations that Amazon Web Services recommends that you
    /// purchase.
    dynamo_db_capacity_details: ?DynamoDBCapacityDetails,

    pub const json_field_names = .{
        .dynamo_db_capacity_details = "DynamoDBCapacityDetails",
    };
};
