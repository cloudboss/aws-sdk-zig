/// The type of field. The valid options for a field depend on the field type.
/// For more information about the supported field types, see [Configuring Index
/// Fields](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-index-fields.html) in the *Amazon CloudSearch Developer Guide*.
pub const IndexFieldType = enum {
    int,
    double,
    literal,
    text,
    date,
    latlon,
    int_array,
    double_array,
    literal_array,
    text_array,
    date_array,
};
