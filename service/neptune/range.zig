/// A range of integer values.
pub const Range = struct {
    /// The minimum value in the range.
    from: ?i32,

    /// The step value for the range. For example, if you have a range of 5,000 to
    /// 10,000, with a
    /// step value of 1,000, the valid values start at 5,000 and step up by 1,000.
    /// Even though 7,500
    /// is within the range, it isn't a valid value for the range. The valid values
    /// are 5,000, 6,000,
    /// 7,000, 8,000...
    step: ?i32,

    /// The maximum value in the range.
    to: ?i32,
};
