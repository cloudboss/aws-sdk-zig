const InterfaceRequest = @import("interface_request.zig").InterfaceRequest;

/// The transport parameters that you want to associate with an incoming media
/// stream.
pub const InputConfigurationRequest = struct {
    /// The port that you want the flow to listen on for an incoming media stream.
    input_port: i32,

    /// The VPC interface that you want to use for the incoming media stream.
    interface: InterfaceRequest,

    pub const json_field_names = .{
        .input_port = "InputPort",
        .interface = "Interface",
    };
};
