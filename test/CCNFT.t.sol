// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/BUSD.sol";
import "../src/CCNFT.sol";

// Definición del contrato de prueba CCNFTTest que hereda de Test. 
// Declaración de direcciones y dos instancias de contratos (BUSD y CCNFT).
contract CCNFTTest is Test {
    address deployer;
    address c1;
    address c2;
    address funds;
    address fees;
    BUSD busd;
    CCNFT ccnft;

// Ejecución antes de cada prueba. 
// Inicializar las direcciones y desplegar las instancias de BUSD y CCNFT.
    function setUp() public {
        deployer = address(this);
        c1 = address(0xC1);
        c2 = address(0xC2);
        funds = address(0xF1);
        fees = address(0xFe4);
        busd = new BUSD();
        ccnft = new CCNFT();

        // Configuración inicial del contrato CCNFT
        ccnft.setFundsToken(address(busd));
        ccnft.setFundsCollector(funds);
        ccnft.setFeesCollector(fees);

    }

// Prueba de "setFundsCollector" del contrato CCNFT. 
// Llamar al método y despues verificar que el valor se haya establecido correctamente.
    function testSetFundsCollector() public {
        ccnft.setFundsCollector(funds);
        assertEq(ccnft.fundsCollector(), funds);
    }

// Prueba de "setFeesCollector" del contrato CCNFT
// Verificar que el valor se haya establecido correctamente.
    function testSetFeesCollector() public {
        ccnft.setFeesCollector(fees);
        assertEq(ccnft.feesCollector(), fees);
    }

// Prueba de "setProfitToPay" del contrato CCNFT
// Verificar que el valor se haya establecido correctamente.
    function testSetProfitToPay() public {
        uint32 profit = 100;
        ccnft.setProfitToPay(profit);
        assertEq(ccnft.profitToPay(), profit);
    }

// Prueba de "setCanBuy" primero estableciéndolo en true y verificando que se establezca correctamente.
// Despues establecerlo en false verificando nuevamente.
    function testSetCanBuy() public {
        ccnft.setCanBuy(true);
        assertTrue(ccnft.canBuy());

        ccnft.setCanBuy(false);
        assertFalse(ccnft.canBuy());
    }

// Prueba de método "setCanTrade". Similar a "testSetCanBuy".
    function testSetCanTrade() public {
        ccnft.setCanTrade(true);
        assertTrue(ccnft.canTrade());

        ccnft.setCanTrade(false);
        assertFalse(ccnft.canTrade());
    }

// Prueba de método "setCanClaim". Similar a "testSetCanBuy".
    function testSetCanClaim() public {
        ccnft.setCanClaim(true);
        assertTrue(ccnft.canClaim());

        ccnft.setCanClaim(false);
        assertFalse(ccnft.canClaim());
    }

// Prueba de "setMaxValueToRaise" con diferentes valores.
// Verifica que se establezcan correctamente.
    function testSetMaxValueToRaise() public {
        uint256 value1 = 1000;
        ccnft.setMaxValueToRaise(value1);
        assertEq(ccnft.maxValueToRaise(), value1);

        uint256 value2 = 2000;
        ccnft.setMaxValueToRaise(value2);
        assertEq(ccnft.maxValueToRaise(), value2);
    }

// Prueba de "addValidValues" añadiendo diferentes valores.
// Verificar que se hayan añadido correctamente.
    function testAddValidValues() public {
        ccnft.addValidValues(100);
        assertTrue(ccnft.validValues(100));

        ccnft.addValidValues(200);
        assertTrue(ccnft.validValues(200));

        assertFalse(ccnft.validValues(300)); // Verificar un valor no añadido
    }

// Prueba de "setMaxBatchCount".
// Verifica que el valor se haya establecido correctamente.
    function testSetMaxBatchCount() public {
        uint16 maxBatchCount = 10;
        ccnft.setMaxBatchCount(maxBatchCount);
        assertEq(ccnft.maxBatchCount(), maxBatchCount);
    }

// Prueba de "setBuyFee".
// Verificar que el valor se haya establecido correctamente.
    function testSetBuyFee() public {
        uint16 buyFee = 5; // Porcentaje de comisión
        ccnft.setBuyFee(buyFee);
        assertEq(ccnft.buyFee(), buyFee);
    }

// Prueba de "setTradeFee".
// Verificar que el valor se haya establecido correctamente.
    function testSetTradeFee() public {
        uint16 tradeFee = 3; // Porcentaje de comisión
        ccnft.setTradeFee(tradeFee);
        assertEq(ccnft.tradeFee(), tradeFee);
    }

// Prueba de que no se pueda comerciar cuando canTrade es false.
// Verificar que se lance un error esperado.
    function testCannotTradeWhenCanTradeIsFalse() public {
        ccnft.setCanTrade(false);
        vm.expectRevert(unicode"El comercio de NFTs no está habilitado");
        ccnft.trade(1);
    }

// Prueba que no se pueda comerciar con un token que no existe, incluso si canTrade es true. 
// Verificar que se lance un error esperado.
    function testCannotTradeWhenTokenDoesNotExist() public {
        ccnft.setCanTrade(true);
        vm.expectRevert(unicode"El token no existe");
        ccnft.trade(9999); // ID de token que no existe
    }
}
