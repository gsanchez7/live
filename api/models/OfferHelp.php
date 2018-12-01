<?php
    class OfferHelp {

        // db connection and table
        private $conn;
        private $table = 'helpers';

        // offer help properties
        public $id;
        public $childCare;
        public $elderCare;
        public $animalCare;
        public $startDate;
        public $endDate;
        public $description;
        public $price;
        public $latitude;
        public $longitude;

        // constructor with DB and login properties
        public function __construct($db,
            $id,
            $childCare,
            $elderCare,
            $animalCare,
            $startDate,
            $endDate,
            $description,
            $price,
            $latitude,
            $longitude
        ) {
            $this->conn = $db;
            $this->id = $id;
            $this->childCare = $childCare;
            $this->elderCare = $elderCare;
            $this->animalCare = $animalCare;
            $this->startDate = $startDate;
            $this->endDate = $endDate;
            $this->description = $description;
            $this->price = $price;
            $this->latitude = $latitude;
            $this->longitude = $longitude;
        }

        // attempt offer help
        public function offerHelp() {

            $query = "INSERT INTO
                      $this->table
                      (
                      `user_id`, 
                      `child_care`,
                      `elder_care`,
                      `animal_care`,
                      `start_date`,
                      `end_date`,
                      `description`,
                      `price`,
                      `latitude`,
                      `longitude`
                      ) 
                      VALUES
                      (
                      '$this->id',
                      '$this->childCare',
                      '$this->elderCare',
                      '$this->animalCare',
                      '$this->startDate',
                      '$this->endDate',
                      '$this->description',
                      '$this->price',
                      '$this->latitude',
                      '$this->longitude'
                      )
                      ON DUPLICATE KEY UPDATE
                      child_care = '$this->childCare',
                      elder_care = '$this->elderCare',
                      animal_care = '$this->animalCare',
                      start_date = '$this->startDate',
                      end_date = '$this->endDate',
                      description = '$this->description',
                      price = '$this->price',
                      latitude = '$this->latitude',
                      longitude = '$this->longitude'";

            // prepeare statement
            $stmt = $this->conn->prepare($query);

            // exceute query
            $stmt->execute();

            // return statement
            return $stmt;
        }
    }
?>