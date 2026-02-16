import 'models.dart';

// Mock city data
final List<City> cities = [
  City(
    code: 'NYC',
    name: 'New York',
    displayName: 'New York (NYC - All Airports)',
    region: 'New York',
    country: 'United States',
  ),
  City(
    code: 'ATL',
    name: 'Atlanta',
    displayName: 'Atlanta (ATL - Hartsfield-Jackson Atlanta Intl.)',
    region: 'Georgia',
    country: 'United States',
  ),
  City(
    code: 'AUS',
    name: 'Austin',
    displayName: 'Austin (AUS - Austin-Bergstrom Intl.)',
    region: 'Texas',
    country: 'United States',
  ),
  City(
    code: 'AUA',
    name: 'Oranjestad',
    displayName: 'Oranjestad (AUA - Queen Beatrix Intl.)',
    region: '',
    country: 'Aruba',
  ),
  City(
    code: 'PHX',
    name: 'Phoenix',
    displayName: 'Phoenix (PHX - Sky Harbor Intl.)',
    region: 'Arizona',
    country: 'United States',
  ),
  City(
    code: 'ADD',
    name: 'Addis Ababa',
    displayName: 'Addis Ababa (ADD - Bole Intl.)',
    region: 'Addis Ababa',
    country: 'Ethiopia',
  ),
];

// Cabin classes
final List<String> cabinClasses = [
  'Economy',
  'Premium economy',
  'Business class',
  'First class',
];

// Mock flights
final List<Flight> flightsMock = [
  Flight(
    fromCode: 'ADD',
    toCode: 'ATL',
    airline: 'Lufthansa',
    operator: 'Ethiopian Airlines and Lufthansa',
    departureTime: '12:20am',
    arrivalTime: '2:30pm',
    duration: '22h 10m',
    stops: 1,
    stopText: '1 stop',
    price: '\$902',
    cabin: 'Economy',
    seatsLeft: 4,
    logoAsset: '', // Asset path or leave blank for mock
    legs: [
      FlightLeg(
        airline: 'Lufthansa',
        flightNumber: 'LH9695',
        fromCity: 'Addis Ababa',
        toCity: 'Frankfurt',
        fromAirport: 'Bole Intl. (ADD)',
        toAirport: 'Frankfurt Intl. (FRA)',
        depTime: '12:20am',
        arrTime: '5:45am',
        travelTime: '7h 25m',
        terminalFrom: 'Terminal 2',
        terminalTo: 'Terminal 1',
        distance: '3324 mi',
        aircraft: 'AIRBUS INDUSTRIE A350-900',
        cabin: 'Economy',
        amenities: ['WiFi', 'In-seat power outlet', 'In-flight entertainment'],
        emission: 'Above average CO₂',
      ),
      FlightLeg(
        airline: 'Lufthansa',
        flightNumber: 'LH444',
        fromCity: 'Frankfurt',
        toCity: 'Atlanta',
        fromAirport: 'Frankfurt Intl. (FRA)',
        toAirport: 'Hartsfield-Jackson Atlanta Intl. (ATL)',
        depTime: '10:30am',
        arrTime: '2:30pm',
        travelTime: '10h 0m',
        terminalFrom: 'Terminal 2',
        terminalTo: 'Terminal I',
        distance: '5000 mi',
        aircraft: 'AIRBUS INDUSTRIE A350-900',
        cabin: 'Economy',
        amenities: ['WiFi', 'In-seat power outlet', 'In-flight entertainment'],
        emission: 'Above average CO₂',
      ),
    ],
  ),
  // Add more flights for mock results as seen fit, similar to Image 3
];