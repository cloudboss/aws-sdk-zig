const OperatorType = @import("operator_type.zig").OperatorType;

/// Contains a logical operation for comparing the value of a field with a
/// specified value.
pub const Operator = struct {
    /// The logical operation to be performed: equal (`EQ`), equal reference
    /// (`REF_EQ`), less than or equal (`LE`), greater than or equal (`GE`), or
    /// between (`BETWEEN`). Equal reference (`REF_EQ`) can be used only with
    /// reference fields. The other comparison types can be used only with String
    /// fields. The comparison types you can use apply only to certain object
    /// fields, as detailed below.
    ///
    /// The comparison operators EQ and REF_EQ act on the following fields:
    ///
    /// * name
    ///
    /// * @sphere
    ///
    /// * parent
    ///
    /// * @componentParent
    ///
    /// * @instanceParent
    ///
    /// * @status
    ///
    /// * @scheduledStartTime
    ///
    /// * @scheduledEndTime
    ///
    /// * @actualStartTime
    ///
    /// * @actualEndTime
    ///
    /// The comparison operators `GE`, `LE`, and `BETWEEN` act on the following
    /// fields:
    ///
    /// * @scheduledStartTime
    ///
    /// * @scheduledEndTime
    ///
    /// * @actualStartTime
    ///
    /// * @actualEndTime
    ///
    /// Note that fields beginning with the at sign (@) are read-only and set by the
    /// web service. When you name fields, you should choose names containing only
    /// alpha-numeric values, as symbols may be reserved by AWS Data Pipeline.
    /// User-defined fields that you add to a pipeline should prefix their name with
    /// the string "my".
    @"type": ?OperatorType = null,

    /// The value that the actual field value will be compared with.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .@"type" = "type",
        .values = "values",
    };
};
