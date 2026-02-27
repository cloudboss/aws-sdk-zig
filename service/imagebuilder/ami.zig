const ImageState = @import("image_state.zig").ImageState;

/// Details of an Amazon EC2 AMI.
pub const Ami = struct {
    /// The account ID of the owner of the AMI.
    account_id: ?[]const u8,

    /// The description of the Amazon EC2 AMI. Minimum and maximum length are in
    /// characters.
    description: ?[]const u8,

    /// The AMI ID of the Amazon EC2 AMI.
    image: ?[]const u8,

    /// The name of the Amazon EC2 AMI.
    name: ?[]const u8,

    /// The Amazon Web Services Region of the Amazon EC2 AMI.
    region: ?[]const u8,

    state: ?ImageState,

    pub const json_field_names = .{
        .account_id = "accountId",
        .description = "description",
        .image = "image",
        .name = "name",
        .region = "region",
        .state = "state",
    };
};
