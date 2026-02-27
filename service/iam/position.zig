/// Contains the row and column of a location of a `Statement` element in a
/// policy document.
///
/// This data type is used as a member of the `
/// [Statement](https://docs.aws.amazon.com/IAM/latest/APIReference/API_Statement.html)
/// ` type.
pub const Position = struct {
    /// The column in the line containing the specified position in the document.
    column: i32 = 0,

    /// The line containing the specified position in the document.
    line: i32 = 0,
};
