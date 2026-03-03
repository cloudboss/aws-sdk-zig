/// Options for sending VPN tunnel logs to CloudWatch.
pub const CloudWatchLogOptionsSpecification = struct {
    /// Specifies whether to enable BGP logging for the VPN connection. Default
    /// value is `False`.
    ///
    /// Valid values: `True` | `False`
    bgp_log_enabled: ?bool = null,

    /// The Amazon Resource Name (ARN) of the CloudWatch log group where BGP logs
    /// will be sent.
    bgp_log_group_arn: ?[]const u8 = null,

    /// The desired output format for BGP logs to be sent to CloudWatch. Default
    /// format is `json`.
    ///
    /// Valid values: `json` | `text`
    bgp_log_output_format: ?[]const u8 = null,

    /// Enable or disable VPN tunnel logging feature. Default value is `False`.
    ///
    /// Valid values: `True` | `False`
    log_enabled: ?bool = null,

    /// The Amazon Resource Name (ARN) of the CloudWatch log group to send logs to.
    log_group_arn: ?[]const u8 = null,

    /// Set log format. Default format is `json`.
    ///
    /// Valid values: `json` | `text`
    log_output_format: ?[]const u8 = null,
};
