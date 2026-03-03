const AcceleratorCountRange = @import("accelerator_count_range.zig").AcceleratorCountRange;
const AcceleratorSelection = @import("accelerator_selection.zig").AcceleratorSelection;

/// Provides information about the GPU accelerators used for jobs processed by a
/// fleet.
///
/// Accelerator capabilities cannot be used with wait-and-save fleets. If you
/// specify accelerator capabilities, you must use either spot or on-demand
/// instance market options.
///
/// Each accelerator type maps to specific EC2 instance families:
///
/// * `t4`: Uses G4dn instance family
/// * `a10g`: Uses G5 instance family
/// * `l4`: Uses G6 and Gr6 instance families
/// * `l40s`: Uses G6e instance family
pub const AcceleratorCapabilities = struct {
    /// The number of GPU accelerators specified for worker hosts in this fleet.
    ///
    /// You must specify either `acceleratorCapabilities.count.max` or
    /// `allowedInstanceTypes` when using accelerator capabilities. If you don't
    /// specify a maximum count, Amazon Web Services Deadline Cloud uses the
    /// instance types you specify in `allowedInstanceTypes` to determine the
    /// maximum number of accelerators.
    count: ?AcceleratorCountRange = null,

    /// A list of accelerator capabilities requested for this fleet. Only Amazon
    /// Elastic Compute Cloud instances that provide these capabilities will be
    /// used. For example, if you specify both L4 and T4 chips, Amazon Web Services
    /// Deadline Cloud will use Amazon EC2 instances that have either the L4 or the
    /// T4 chip installed.
    ///
    /// * You must specify at least one accelerator selection.
    /// * You cannot specify the same accelerator name multiple times in the
    ///   selections list.
    /// * All accelerators in the selections must use the same runtime version.
    selections: []const AcceleratorSelection,

    pub const json_field_names = .{
        .count = "count",
        .selections = "selections",
    };
};
