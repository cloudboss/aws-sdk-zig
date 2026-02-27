const OptionState = @import("option_state.zig").OptionState;

/// The status of domain configuration option.
pub const OptionStatus = struct {
    /// A timestamp for when this option was created.
    creation_date: i64,

    /// Indicates that the option will be deleted once processing is complete.
    pending_deletion: ?bool,

    /// The state of processing a change to an option. Possible values:
    ///
    /// * `RequiresIndexDocuments`: the option's latest value will not be deployed
    ///   until IndexDocuments has been called and indexing is complete.
    ///
    /// * `Processing`: the option's latest value is in the process of being
    ///   activated.
    ///
    /// * `Active`: the option's latest value is completely deployed.
    ///
    /// * `FailedToValidate`: the option value is not compatible with the domain's
    ///   data and cannot be used to index the data. You must either modify the
    ///   option value or update or remove the incompatible documents.
    state: OptionState,

    /// A timestamp for when this option was last updated.
    update_date: i64,

    /// A unique integer that indicates when this option was last updated.
    update_version: i32 = 0,
};
