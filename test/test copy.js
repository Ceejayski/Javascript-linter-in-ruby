class @Car2sd {
    constructor(brand,model,year){
        this.brand = brand;
        this.model = model;
        this.year =year
    }

    displayCarInformation() {
        console.log(this.brand+' '+this.model+' '+this.year)
    }

}
class CarService{
    constructor(name,country){
        this.name = name;
        this.country = country;
    this.carsToRepairs = new Array();
    }
    addcar(car){
        this.carsToRepairs.push(car);
    }
}
{}{}}
()(