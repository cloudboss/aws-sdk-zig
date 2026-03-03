const DeliveryDestinationType = @import("delivery_destination_type.zig").DeliveryDestinationType;

pub const UpdateDestinationRequest = struct {
    /// The Amazon Resource Name (ARN) of the customer-managed destination.
    delivery_destination_arn: ?[]const u8 = null,

    /// The destination type for the customer-managed destination.
    delivery_destination_type: ?DeliveryDestinationType = null,

    /// The description of the customer-managed destination.
    description: ?[]const u8 = null,

    /// The name of the customer-managed destination.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the delivery destination role.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .delivery_destination_arn = "DeliveryDestinationArn",
        .delivery_destination_type = "DeliveryDestinationType",
        .description = "Description",
        .name = "Name",
        .role_arn = "RoleArn",
    };
};
