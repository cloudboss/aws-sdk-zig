const Checksum = @import("checksum.zig").Checksum;
const ModelState = @import("model_state.zig").ModelState;

pub const Definition = struct {
    /// The checksum information of the model.
    checksum: ?Checksum,

    /// The unique model handle.
    model_handle: ?[]const u8,

    /// The absolute S3 location of the model.
    s3_url: ?[]const u8,

    /// The desired state of the model.
    state: ?ModelState,

    pub const json_field_names = .{
        .checksum = "Checksum",
        .model_handle = "ModelHandle",
        .s3_url = "S3Url",
        .state = "State",
    };
};
