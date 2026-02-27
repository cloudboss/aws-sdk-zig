const Interface = @import("interface.zig").Interface;

/// The transport parameters that are associated with an incoming media stream.
pub const InputConfiguration = struct {
    /// The IP address that the flow listens on for incoming content for a media
    /// stream.
    input_ip: []const u8,

    /// The port that the flow listens on for an incoming media stream.
    input_port: i32,

    /// The VPC interface where the media stream comes in from.
    interface: Interface,

    pub const json_field_names = .{
        .input_ip = "InputIp",
        .input_port = "InputPort",
        .interface = "Interface",
    };
};
