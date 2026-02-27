/// A configuration to store the Tickerplant logs. It consists of
/// a list of volumes that will be mounted to your cluster. For the cluster type
/// `Tickerplant`, the location of the TP volume on the cluster will be
/// available by using the global variable `.aws.tp_log_path`.
pub const TickerplantLogConfiguration = struct {
    /// The name of the volumes for tickerplant logs.
    tickerplant_log_volumes: ?[]const []const u8,

    pub const json_field_names = .{
        .tickerplant_log_volumes = "tickerplantLogVolumes",
    };
};
