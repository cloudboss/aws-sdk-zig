const ProxyMode = @import("proxy_mode.zig").ProxyMode;

/// Contains configuration for PROXY protocol version 2 (PPv2) support on an
/// Transfer Family server. When enabled, Transfer Family reads the added PPv2
/// header from incoming connections to extract the client's source IP address.
/// This address is then available in Amazon CloudWatch Logs entries and is
/// passed to custom identity providers during authentication, enabling IP-based
/// access policies. For more information, see [Working with Network Load
/// Balancers](https://docs.aws.amazon.com/transfer/latest/userguide/working-with-nlb.html).
pub const ProxyConfig = struct {
    /// Specifies whether the Transfer Family server requires or ignores a PPv2
    /// header containing the client's source IP address on incoming SFTP
    /// connections. If you don't specify a value, the default is `NONE`
    ///
    /// * `NONE`: the server reads and ignores any PPv2 header on incoming SFTP
    ///   connections. This is the default value. Use this value when your SFTP
    ///   server is not behind an NLB, or when you do not need to preserve the
    ///   client's source IP address through an NLB.
    /// * `PROXY_PROTOCOL_V2_ENFORCED`: the server requires a valid PPv2 header on
    ///   every incoming SFTP connection. When a valid header is present, the server
    ///   applies it and uses the source IP address from the header. If a connection
    ///   arrives without a PPv2 header, the server refuses the connection and logs
    ///   an error to Amazon CloudWatch Logs indicating that the expected PPv2
    ///   header was missing. Use this value when your SFTP server is behind an NLB
    ///   with PPv2 enabled on the target group.
    ///
    /// With `PROXY_PROTOCOL_V2_ENFORCED` you must restrict the server's VPC
    /// endpoint security group to allow inbound traffic only via the trusted NLB.
    /// For more information, see [Working with Network Load
    /// Balancers](https://docs.aws.amazon.com/transfer/latest/userguide/working-with-nlb.html).
    sftp_mode: ?ProxyMode = null,

    pub const json_field_names = .{
        .sftp_mode = "SftpMode",
    };
};
