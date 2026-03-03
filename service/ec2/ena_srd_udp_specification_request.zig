/// Configures ENA Express for UDP network traffic from your launch template.
pub const EnaSrdUdpSpecificationRequest = struct {
    /// Indicates whether UDP traffic uses ENA Express for your instance. To ensure
    /// that UDP
    /// traffic can use ENA Express when you launch an instance, you must also set
    /// **EnaSrdEnabled** in the **EnaSrdSpecificationRequest** to `true`.
    ena_srd_udp_enabled: ?bool = null,
};
