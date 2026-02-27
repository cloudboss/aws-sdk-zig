/// Contains configuration for X12 control numbers used in X12 EDI generation.
/// Control numbers are used to uniquely identify interchanges, functional
/// groups, and transaction sets.
pub const X12ControlNumbers = struct {
    /// Specifies the starting functional group control number (GS06) to use for X12
    /// EDI generation. This number is incremented for each new functional group.
    /// For the GS (functional group) envelope, Amazon Web Services B2B Data
    /// Interchange generates a functional group control number that is unique to
    /// the sender ID, receiver ID, and functional identifier code combination.
    starting_functional_group_control_number: ?i32,

    /// Specifies the starting interchange control number (ISA13) to use for X12 EDI
    /// generation. This number is incremented for each new interchange. For the ISA
    /// (interchange) envelope, Amazon Web Services B2B Data Interchange generates
    /// an interchange control number that is unique for the ISA05 and ISA06
    /// (sender) & ISA07 and ISA08 (receiver) combination.
    starting_interchange_control_number: ?i32,

    /// Specifies the starting transaction set control number (ST02) to use for X12
    /// EDI generation. This number is incremented for each new transaction set.
    starting_transaction_set_control_number: ?i32,

    pub const json_field_names = .{
        .starting_functional_group_control_number = "startingFunctionalGroupControlNumber",
        .starting_interchange_control_number = "startingInterchangeControlNumber",
        .starting_transaction_set_control_number = "startingTransactionSetControlNumber",
    };
};
