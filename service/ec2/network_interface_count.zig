/// The minimum and maximum number of network interfaces.
pub const NetworkInterfaceCount = struct {
    /// The maximum number of network interfaces. If this parameter is not
    /// specified, there is no
    /// maximum limit.
    max: ?i32 = null,

    /// The minimum number of network interfaces. If this parameter is not
    /// specified, there is no
    /// minimum limit.
    min: ?i32 = null,
};
