const LowReputationMode = @import("low_reputation_mode.zig").LowReputationMode;

/// Configures the level of DDoS protection that applies to web ACLs associated
/// with Application Load Balancers.
pub const OnSourceDDoSProtectionConfig = struct {
    /// The level of DDoS protection that applies to web ACLs associated with
    /// Application Load Balancers. `ACTIVE_UNDER_DDOS` protection is enabled by
    /// default whenever a web ACL is associated with an Application Load Balancer.
    /// In the event that an Application Load Balancer experiences high-load
    /// conditions or suspected DDoS attacks, the `ACTIVE_UNDER_DDOS` protection
    /// automatically rate limits traffic from known low reputation sources without
    /// disrupting Application Load Balancer availability.
    /// `ALWAYS_ON` protection provides constant, always-on monitoring of known low
    /// reputation sources for suspected DDoS attacks. While this provides a higher
    /// level of protection, there may be potential impacts on legitimate traffic.
    alb_low_reputation_mode: LowReputationMode,

    pub const json_field_names = .{
        .alb_low_reputation_mode = "ALBLowReputationMode",
    };
};
