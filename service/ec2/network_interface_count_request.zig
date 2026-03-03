/// The minimum and maximum number of network interfaces.
pub const NetworkInterfaceCountRequest = struct {
    /// The maximum number of network interfaces. To specify no maximum limit, omit
    /// this
    /// parameter.
    max: ?i32 = null,

    /// The minimum number of network interfaces. To specify no minimum limit, omit
    /// this
    /// parameter.
    min: ?i32 = null,
};
