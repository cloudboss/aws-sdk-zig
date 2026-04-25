/// Describes the starting parameters for a Managed Service for Apache Flink
/// application.
pub const FlinkRunConfiguration = struct {
    /// When restoring from a snapshot, specifies whether the runtime is allowed to
    /// skip a state that cannot
    /// be mapped to the new program.
    /// This will happen if the program is updated between snapshots to remove
    /// stateful parameters, and
    /// state data in the snapshot no longer
    /// corresponds to valid application data. For more information, see
    /// [
    /// Allowing Non-Restored
    /// State](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/state/savepoints/#allowing-non-restored-state) in the [Apache Flink
    /// documentation](https://nightlies.apache.org/flink/flink-docs-release-2.2/).
    ///
    /// This value defaults to `false`. If you update your application without
    /// specifying this parameter, `AllowNonRestoredState` will be set to `false`,
    /// even if it was previously set to `true`.
    allow_non_restored_state: ?bool = null,

    pub const json_field_names = .{
        .allow_non_restored_state = "AllowNonRestoredState",
    };
};
