const CanInterface = @import("can_interface.zig").CanInterface;
const CustomDecodingInterface = @import("custom_decoding_interface.zig").CustomDecodingInterface;
const ObdInterface = @import("obd_interface.zig").ObdInterface;
const NetworkInterfaceType = @import("network_interface_type.zig").NetworkInterfaceType;
const VehicleMiddleware = @import("vehicle_middleware.zig").VehicleMiddleware;

/// Represents a node and its specifications in an in-vehicle communication
/// network. All
/// signal decoders must be associated with a network node.
///
/// To return this information about all the network interfaces specified in a
/// decoder
/// manifest, use the API
/// operation.
pub const NetworkInterface = struct {
    /// Information about a network interface specified by the Controller Area
    /// Network (CAN)
    /// protocol.
    can_interface: ?CanInterface,

    /// Information about a [custom network
    /// interface](https://docs.aws.amazon.com/iot-fleetwise/latest/APIReference/API_CustomDecodingInterface.html).
    custom_decoding_interface: ?CustomDecodingInterface,

    /// The ID of the network interface.
    interface_id: []const u8,

    /// Information about a network interface specified by the on-board diagnostic
    /// (OBD) II
    /// protocol.
    obd_interface: ?ObdInterface,

    /// The network protocol for the vehicle. For example, `CAN_SIGNAL` specifies a
    /// protocol that defines how data is communicated between electronic control
    /// units (ECUs).
    /// `OBD_SIGNAL` specifies a protocol that defines how self-diagnostic data
    /// is communicated between ECUs.
    type: NetworkInterfaceType,

    /// The vehicle middleware defined as a type of network interface. Examples of
    /// vehicle
    /// middleware include `ROS2` and `SOME/IP`.
    vehicle_middleware: ?VehicleMiddleware,

    pub const json_field_names = .{
        .can_interface = "canInterface",
        .custom_decoding_interface = "customDecodingInterface",
        .interface_id = "interfaceId",
        .obd_interface = "obdInterface",
        .type = "type",
        .vehicle_middleware = "vehicleMiddleware",
    };
};
