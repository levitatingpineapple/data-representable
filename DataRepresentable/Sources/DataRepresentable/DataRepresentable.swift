import Foundation

public struct TestMe { }

public protocol DataRepresentable {
	init?(data: Data)
	var data: Data { get }
}

extension Numeric {
	public var data: Data { Data(withUnsafeBytes(of: self, Array.init)) }
}

// MARK: UnsignedInteger
extension UInt8: DataRepresentable {
	public init?(data: Data) {
		if data.count != MemoryLayout<Self>.size { return nil }
		self.init(
			littleEndian: data.withUnsafeBytes { $0.load(as: Self.self) }
		)
	}
}

extension UInt16: DataRepresentable {
	public init?(data: Data) {
		if data.count != MemoryLayout<Self>.size { return nil }
		self.init(
			littleEndian: data.withUnsafeBytes { $0.load(as: Self.self) }
		)
	}
}

extension UInt32: DataRepresentable {
	public init?(data: Data) {
		if data.count != MemoryLayout<Self>.size { return nil }
		self.init(
			littleEndian: data.withUnsafeBytes { $0.load(as: Self.self) }
		)
	}
}

extension UInt64: DataRepresentable {
	public init?(data: Data) {
		if data.count != MemoryLayout<Self>.size { return nil }
		self.init(
			littleEndian: data.withUnsafeBytes { $0.load(as: Self.self) }
		)
	}
}

// MARK: SignedInteger
extension Int8: DataRepresentable {
	public init?(data: Data) {
		guard let bitPattern = UInt8(data: data) else { return nil }
		self.init(bitPattern: bitPattern)
	}
}

extension Int16: DataRepresentable {
	public init?(data: Data) {
		guard let bitPattern = UInt16(data: data) else { return nil }
		self.init(bitPattern: bitPattern)
	}
}

extension Int32: DataRepresentable {
	public init?(data: Data) {
		guard let bitPattern = UInt32(data: data) else { return nil }
		self.init(bitPattern: bitPattern)
	}
}

extension Int64: DataRepresentable {
	public init?(data: Data) {
		guard let bitPattern = UInt64(data: data) else { return nil }
		self.init(bitPattern: bitPattern)
	}
}

// MARK: FloatingPoint
extension Float: DataRepresentable {
	public init?(data: Data) {
		guard let bitPattern = UInt32(data: data) else { return nil }
		self.init(bitPattern: bitPattern)
	}
}

extension Double: DataRepresentable {
	public init?(data: Data) {
		guard let bitPattern = UInt64(data: data) else { return nil }
		self.init(bitPattern: bitPattern)
	}
}

// MARK: Other
extension Bool: DataRepresentable {
	public init?(data: Data) {
		switch UInt8(data: data) {
		case 0: self.init(false)
		case 1: self.init(true)
		default: return nil
		}
	}
	public var data: Data { Data([self ? 1 : 0]) }
}

extension String: DataRepresentable {
	public init?(data: Data) {
		self.init(data: data, encoding: .utf8)
	}
	public var data: Data { data(using: .utf8)! }
}
