/// Options for sending VPN tunnel logs to CloudWatch.
pub const CloudWatchLogOptions = struct {
    /// Indicates whether Border Gateway Protocol (BGP) logging is enabled for the
    /// VPN connection. Default value is `False`.
    ///
    /// Valid values: `True` | `False`
    bgp_log_enabled: ?bool,

    /// The Amazon Resource Name (ARN) of the CloudWatch log group for BGP logs.
    bgp_log_group_arn: ?[]const u8,

    /// The output format for BGP logs sent to CloudWatch. Default format is `json`.
    ///
    /// Valid values: `json` | `text`
    bgp_log_output_format: ?[]const u8,

    /// Status of VPN tunnel logging feature. Default value is `False`.
    ///
    /// Valid values: `True` | `False`
    log_enabled: ?bool,

    /// The Amazon Resource Name (ARN) of the CloudWatch log group to send logs to.
    log_group_arn: ?[]const u8,

    /// Configured log format. Default format is `json`.
    ///
    /// Valid values: `json` | `text`
    log_output_format: ?[]const u8,
};
