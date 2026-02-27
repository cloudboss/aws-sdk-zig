const ByoipCidrEvent = @import("byoip_cidr_event.zig").ByoipCidrEvent;
const ByoipCidrState = @import("byoip_cidr_state.zig").ByoipCidrState;

/// Information about an IP address range that is provisioned for use with your
/// Amazon Web Services resources through
/// bring your own IP address (BYOIP).
///
/// The following describes each BYOIP `State` that your IP address range can be
/// in.
///
/// * **PENDING_PROVISIONING** —
/// You’ve submitted a request to provision an IP address range but it is not
/// yet provisioned with
/// Global Accelerator.
///
/// * **READY** — The address range is provisioned
/// with Global Accelerator and can be advertised.
///
/// * **PENDING_ADVERTISING** — You’ve submitted a
/// request for Global Accelerator to advertise an address range but it is not
/// yet being advertised.
///
/// * **ADVERTISING** — The address range is
/// being advertised by Global Accelerator.
///
/// * **PENDING_WITHDRAWING** — You’ve submitted
/// a request to withdraw an address range from being advertised but it is still
/// being advertised
/// by Global Accelerator.
///
/// * **PENDING_DEPROVISIONING** — You’ve submitted a
/// request to deprovision an address range from Global Accelerator but it is
/// still provisioned.
///
/// * **DEPROVISIONED** — The address range is deprovisioned
/// from Global Accelerator.
///
/// * **FAILED_PROVISION ** — The request to
/// provision the address range from Global Accelerator was not successful.
/// Please make sure that
/// you provide all of the correct information, and try again. If the request
/// fails
/// a second time, contact Amazon Web Services support.
///
/// * **FAILED_ADVERTISING** — The request for Global Accelerator
/// to advertise the address range was not successful. Please make sure that
/// you provide all of the correct information, and try again. If the request
/// fails
/// a second time, contact Amazon Web Services support.
///
/// * **FAILED_WITHDRAW** — The request to withdraw
/// the address range from advertising by Global Accelerator was not successful.
/// Please make sure that
/// you provide all of the correct information, and try again. If the request
/// fails
/// a second time, contact Amazon Web Services support.
///
/// * **FAILED_DEPROVISION ** — The request to
/// deprovision the address range from Global Accelerator was not successful.
/// Please make sure that
/// you provide all of the correct information, and try again. If the request
/// fails
/// a second time, contact Amazon Web Services support.
pub const ByoipCidr = struct {
    /// The address range, in CIDR notation.
    ///
    /// For more information, see
    /// [Bring your own IP addresses
    /// (BYOIP)](https://docs.aws.amazon.com/global-accelerator/latest/dg/using-byoip.html) in
    /// the Global Accelerator Developer Guide.
    cidr: ?[]const u8,

    /// A history of status changes for an IP address range that you bring to Global
    /// Accelerator
    /// through bring your own IP address (BYOIP).
    events: ?[]const ByoipCidrEvent,

    /// The state of the address pool.
    state: ?ByoipCidrState,

    pub const json_field_names = .{
        .cidr = "Cidr",
        .events = "Events",
        .state = "State",
    };
};
