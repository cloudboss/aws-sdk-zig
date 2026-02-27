const Attribute = @import("attribute.zig").Attribute;
const Measurement = @import("measurement.zig").Measurement;
const Metric = @import("metric.zig").Metric;
const Transform = @import("transform.zig").Transform;

/// Contains a property type, which can be one of `attribute`,
/// `measurement`, `metric`, or `transform`.
pub const PropertyType = struct {
    /// Specifies an asset attribute property. An attribute generally contains
    /// static information,
    /// such as the serial number of an
    /// [IIoT](https://en.wikipedia.org/wiki/Internet_of_things#Industrial_applications) wind turbine.
    attribute: ?Attribute,

    /// Specifies an asset measurement property. A measurement represents a device's
    /// raw sensor
    /// data stream, such as timestamped temperature values or timestamped power
    /// values.
    measurement: ?Measurement,

    /// Specifies an asset metric property. A metric contains a mathematical
    /// expression that uses
    /// aggregate functions to process all input data points over a time interval
    /// and output a single
    /// data point, such as to calculate the average hourly temperature.
    metric: ?Metric,

    /// Specifies an asset transform property. A transform contains a mathematical
    /// expression that
    /// maps a property's data points from one form to another, such as a unit
    /// conversion from Celsius
    /// to Fahrenheit.
    transform: ?Transform,

    pub const json_field_names = .{
        .attribute = "attribute",
        .measurement = "measurement",
        .metric = "metric",
        .transform = "transform",
    };
};
